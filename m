Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbUKAMqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbUKAMqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUKAMn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:43:56 -0500
Received: from smtp.cs.aau.dk ([130.225.194.6]:29165 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S261777AbUKAMnA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:43:00 -0500
From: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>
To: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC][2.4 PATCH] A restricted /dev filesystem.
Date: Mon, 1 Nov 2004 13:43:00 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200411012114.IIG42981.tSSMNOFVtPMYFGLOJ@i-love.sakura.ne.jp>
In-Reply-To: <200411012114.IIG42981.tSSMNOFVtPMYFGLOJ@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411011343.00513.ks@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I see your point to some degree...

On Monday 01 November 2004 13:15, Tetsuo Handa wrote:
> Specifications:
>
>   No regular files allowed. (since I think /dev needn't to keep regular
> files.) No hardlinks allowed. (since I think hardlinks are unused for /dev
> .)
Unless your work will be accepted in the vanilla kernel, you will might 
consider making your code a bit more generic.

E.g. these two statements of disallowing creation of hardlinks and regular 
files in /dev can easily be implemented as a LSM module (see 
include/linux/security.h). (I think) You will need to consider the hooks 
inode_create and inode_link only.


Cheers, KS.


-- 
Kristian Sørensen
- The Umbrella Project
  http://umbrella.sourceforge.net

E-mail: ipqw@users.sf.net, Phone: +45 29723816
