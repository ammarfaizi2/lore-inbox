Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbTLKMso (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 07:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbTLKMso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 07:48:44 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:5851 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S264917AbTLKMsm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 07:48:42 -0500
Date: Thu, 11 Dec 2003 07:48:33 -0500
Mime-Version: 1.0 (Apple Message framework v553)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: problem building multiple kernels with correct version numbers
From: ima.sudonim@verizon.net
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <547F5518-2BD8-11D8-B1FC-00039398B344@verizon.net>
X-Mailer: Apple Mail (2.553)
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [141.156.18.128] at Thu, 11 Dec 2003 06:48:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am still relatively new at kernel builds, but I have done a google 
search and tried to follow the process of: make distclean dep vmlinux 
modules modules_install

I have source trees for:
  2.4.20-8d,
2.4.22-2f,
2.4.23-pre5-ben0

Somehow the kernel version in the core Makefile is always: VERSION 2, 
PATCHLEVEL 4, SUBLEVEL 23 EXTRAVERSION -pre5-ben0

When I try to run my prebuilt kernels, the kernelversion info (uname 
-r) is 2.4.23-pre5-ben0
I can't update this value in the Makefile without it getting written 
over from somewhere during the make dep vmlinux process.

i) Where should I put in the kernel source tree an explicit source 
number for the kernel I'm building?

ii) Is there a tool to explicitly set a version string inside a vmlinux 
kernel?

iii) originally, I was just copying configuration information by 
copying .config files from one source directory to another and 
rebuilding. Did I somehow copy kernel version information withit?

iv) is there an option inside make menuconfig to set the kernel's 
version number?

v) when I do a make modules_install, must I already be running the 
vmlinux kernel made for it? It seems to always copy to 
/lib/modules/2.4.23-pre5-ben0

I was using Set version information on all module symbols in Loadable 
module support. Could this have somehow set a kernel version file (if 
such exists) somewhere?

Should I just erase all of my source trees and start over from scratch? 
  Do I need to be running a built kernel to run make_install to update 
/lib/modules for the kernel I've just built?

I am using Yellowdog linux (ppc) 3.01

I do not subscribe to this forum due to heavy traffic but will watch it 
from the website versions.

Thank you!

Ima

