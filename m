Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVBXMIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVBXMIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 07:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVBXMIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 07:08:51 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:47307 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261538AbVBXMHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 07:07:51 -0500
Date: Thu, 24 Feb 2005 13:07:50 +0100
From: bert hubert <ahu@ds9a.nl>
To: J?rn Nettingsmeier <pol-admin@uni-duisburg.de>
Cc: linux-kernel@vger.kernel.org, nettings@folkwang-hochschule.de
Subject: Re: FUTEX deadlock in ping?
Message-ID: <20050224120750.GA18677@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	J?rn Nettingsmeier <pol-admin@uni-duisburg.de>,
	linux-kernel@vger.kernel.org, nettings@folkwang-hochschule.de
References: <421DA915.7020209@uni-duisburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421DA915.7020209@uni-duisburg.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 11:14:45AM +0100, J?rn Nettingsmeier wrote:

> ever since moving to ldap for passwd/group/shadow/hosts lookup, ping to 
> a non-reachable host just freezes up and never returns:
> 
> spunk:~ # strace ping herrnilsson
> execve("/bin/ping", ["ping", "herrnilsson"], [/* 61 vars */]) = 0
> uname({sys="Linux", node="spunk", ...}) = 0
> brk(0)                                  = 0x8063000
> ...
> ...
> munmap(0x40504000, 4096)                = 0
> brk(0x80a5000)                          = 0x80a5000
> uname({sys="Linux", node="spunk", ...}) = 0
> futex(0x401540f4, FUTEX_WAIT, 2, NULL
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Try ping -n. This is most likely something else.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
