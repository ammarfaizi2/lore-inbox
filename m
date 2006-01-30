Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWA3QH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWA3QH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWA3QH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:07:27 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:27843 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932351AbWA3QH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:07:26 -0500
Subject: Re: security capabilities on filesystems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43DD1FB7.9050509@poczta.fm>
References: <43DD1FB7.9050509@poczta.fm>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 30 Jan 2006 11:13:15 -0500
Message-Id: <1138637595.7076.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-29 at 21:04 +0100, Lukasz Stelmach wrote:
> Greetings.
> 
> I've poke around for some information but all I got (was this lousy t-shirt)
> that there is no support for capablities stored on a filesystem. However, I'd
> like to ask if there are any chances to see this feature soon.

Storage of the capability bits isn't the hard part; that is especially
easy these days given the extensible security namespace for extended
attributes that was introduced for SELinux (but not limited to it).

# touch foo
# setfattr -n security.capability.effcap -v 0xdeadbeef foo
# getfattr -e hex -n security.capability.effcap foo
# file: foo
security.capability.effcap=0xdeadbeef

-- 
Stephen Smalley
National Security Agency

