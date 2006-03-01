Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWCAEVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWCAEVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 23:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWCAEVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 23:21:49 -0500
Received: from smtpout.mac.com ([17.250.248.97]:4306 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751497AbWCAEVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 23:21:48 -0500
In-Reply-To: <200603010454.15223.mailinglisten@hauke-laging.de>
References: <200603010328.42008.mailinglisten@hauke-laging.de> <44050AB7.7020202@vilain.net> <200603010454.15223.mailinglisten@hauke-laging.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <08AB14CC-2BB2-4923-BFDB-B1360B5EF405@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: VFS: Dynamic umask for the access rights of linked objects
Date: Tue, 28 Feb 2006 23:21:37 -0500
To: Hauke Laging <mailinglisten@hauke-laging.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 28, 2006, at 22:54:15, Hauke Laging wrote:
> 6) In my scenario the VFS would add a step after 4): It would check  
> if the symlink has been created by someone different from the  
> process's uid and from root. If so there is the risk of abuse and  
> the access check would be repeated for the symlink owner.
>
> 7) The VFS would find out that the symlink owner is not allowed to  
> write to /etc/passwd. Thus the write access is prohibited, even for  
> a process with superuser rights.

Feel free to write an LSM to do this, but it breaks POSIX specs a bit  
and could cause problems with some programs, so it's not likely to  
become the default behavior.

Cheers,
Kyle Moffett


