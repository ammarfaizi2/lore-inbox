Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVAUVs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVAUVs2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVAUVr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:47:27 -0500
Received: from fsmlabs.com ([168.103.115.128]:22977 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262540AbVAUVo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:44:58 -0500
Date: Fri, 21 Jan 2005 14:42:18 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: John Levon <levon@movementarian.org>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] unexport profile_pc
In-Reply-To: <20050120211214.GA75899@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.61.0501211440590.18199@montezuma.fsmlabs.com>
References: <20050120182019.GJ3174@stusta.de> <Pine.LNX.4.61.0501201216420.16780@montezuma.fsmlabs.com>
 <20050120211214.GA75899@compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2005, John Levon wrote:

> On Thu, Jan 20, 2005 at 12:16:52PM -0700, Zwane Mwaikambo wrote:
> 
> > > I haven't found any modular usage of profile_pc in the kernel.
> > 
> > Oprofile?
> 
> We don't actually use it, but it looks like maybe we should? It seems
> unfortunate that readprofile and OProfile should disagree here.

We really should be using it otherwise you get profile hits in the 
spin_lock functions, which isn't really helpful. I recall sending patches 
for this, i may have to resend.

