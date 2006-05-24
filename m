Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWEXTZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWEXTZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 15:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWEXTZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 15:25:47 -0400
Received: from amdext3.amd.com ([139.95.251.6]:23526 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S932147AbWEXTZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 15:25:46 -0400
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Date: Wed, 24 May 2006 13:25:03 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Indrek Kruusa" <indrek.kruusa@artecdesign.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re: long/heavy USB fs operations panics 2.6.16.18
Message-ID: <20060524192503.GJ17964@cosmic.amd.com>
References: <447495CC.7040205@artecdesign.ee>
MIME-Version: 1.0
In-Reply-To: <447495CC.7040205@artecdesign.ee>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 24 May 2006 19:26:17.0644 (UTC)
 FILETIME=[EDE896C0:01C67F67]
X-WSS-ID: 686A6CD327G485923-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Indrek -

> I am investigating a problem with a little custom Geode LX board. It has 
> external USB ide hdd as root and it panics during long/heavy/? disk 
> operation. E.g. 'du -sk /usr' or 'bzip2 -d linux-src.tar.bz2' in my /home.
> Simplest (I suppose) example is fsck panic during boot (output,conf 
> attached).

Is the bug recreatable every single time when you try to fsck?
Have you tried recreating the issue without EHCI?  That should help us
at least narrow it down to the specific USB controller.  

It seems to me like something is causing trouble down somewhere in the
MM subsystem - its almost like something is walking over sensitive parts
of memory - but be it stack or heap, I can't tell.

Jordan

