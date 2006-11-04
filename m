Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752638AbWKDEMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbWKDEMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 23:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbWKDEMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 23:12:17 -0500
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:30339 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1752638AbWKDEMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 23:12:16 -0500
Date: Fri, 3 Nov 2006 23:12:14 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: "Serge E. Hallyn" <serue@us.ibm.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       20060906182719.GB24670@sergelap.austin.ibm.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] security: introduce fs caps
In-Reply-To: <04A6CE5F-C68B-4F1A-B3CB-F3BB77D9EA9A@mac.com>
Message-ID: <Pine.LNX.4.64.0611032309070.15745@d.namei>
References: <20061103175730.87f55ff8.chris@friedhoff.org>
 <20061103200011.GA2206@sergelap.austin.ibm.com>
 <1162585797.5519.175.camel@moss-spartans.epoch.ncsc.mil>
 <20061103204706.GA31398@sergelap.austin.ibm.com> <04A6CE5F-C68B-4F1A-B3CB-F3BB77D9EA9A@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006, Kyle Moffett wrote:

> capabilities anyways.  I guess it _can_ be done, but why?  It's possible to
> set up an SELinux system so that there aren't even any SUID binaries, right?
> /etc/passwd can run as whatever random user and it will automatically
> transition to the appropriate domain such that it can read and modify
> /etc/shadow.

SELinux will not override DAC permissions.  You can theoretically 
configure a system with no effective DAC security and just use MAC, but it 
is definitely not advised.


- James
-- 
James Morris
<jmorris@namei.org>
