Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVBOSdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVBOSdt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVBOSdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:33:49 -0500
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:33778 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261810AbVBOSdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:33:47 -0500
Message-ID: <4212408C.3070804@austin.rr.com>
Date: Tue, 15 Feb 2005 12:33:48 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: keyring API, pam and user space
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I was trying to decipher the kernel keyring API this morning, I 
noticed the gnome-keyring/gnom-keyring manager which I thought might 
have already implemented a pam module to store logon info 
(userid/password at a minimum) in the kernel keyring (could avoid the 
need for prompting for the users password in the mount utility - and 
could better impement "multiuser mounts" across the network ie if I can 
get at the password and username in kernel for a particular uid I could 
automatically setup and usie the correct authenticated session for each 
uid on the client without user intervention if the client is configured 
for that).  We do have a quick and dirty pam module for storing the 
passwords via the kernel keyring API but it is a little ugly since we 
could not find a good header with the syscalls etc. already defined.

Unfortunately in grepping through the current gnome-keyring and 
gnome-keyring-manager code from ftp://ftp.gnome.org/pub/GNOME/sources I 
don't see any calls to the kernel API in the gnome keyring code so I 
doubt that the gnome keyring would be any help.  Has there been any work 
to integrate user space tools (pam helper, keyring GUI and libs) with 
the relatively new kernel keyring code?
