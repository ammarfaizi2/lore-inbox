Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264722AbUFMA32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbUFMA32 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 20:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264729AbUFMA32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 20:29:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:40127 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264722AbUFMA3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 20:29:25 -0400
Date: Sat, 12 Jun 2004 17:28:14 -0700
From: Greg KH <greg@kroah.com>
To: John Stebbins <john@stebbins.name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys_close undefined on x86_64
Message-ID: <20040613002814.GC29873@kroah.com>
References: <1087085478.7036.13.camel@Homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087085478.7036.13.camel@Homer>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2004 at 05:11:18PM -0700, John Stebbins wrote:
> 
> insmod fails with sys_close undefined message when attempting to load
> the module.

Why would a kernel module want to call sys_close directly?  If it's for
firmware loading, the module needs to be ported to use the firmware
download subsystem.

Good luck,

greg k-h
