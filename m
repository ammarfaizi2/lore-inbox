Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUFLEsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUFLEsm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 00:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUFLEsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 00:48:42 -0400
Received: from lakermmtao12.cox.net ([68.230.240.27]:36057 "EHLO
	lakermmtao12.cox.net") by vger.kernel.org with ESMTP
	id S264639AbUFLEsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 00:48:41 -0400
In-Reply-To: <20040611201523.X22989@build.pdx.osdl.net>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <20040611201523.X22989@build.pdx.osdl.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C636D44C-BC2B-11D8-888F-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Sat, 12 Jun 2004 00:48:40 -0400
To: Chris Wright <chrisw@osdl.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 11, 2004, at 23:15, Chris Wright wrote:
> Hrm.  Wouldn't it be possible that two processes with same uid have
> authenticated in different domains, and as such shouldn't be allowed to
> touch each other's PAGs?  Or is this not allowed?

Linux doesn't really support the idea that a process should not be able 
to
affect another process in the same UID.  There's too many things that
would break or become horribly insecure if we tried to assume that.  For
example, just attach a debugger to a process that you want the keys of.
Then just insert a few system calls to retrieve the data, and leave.   
Linux
assumes atomicity of a user/UID and it's not practical to change that.

Cheers,
Kyle Moffett

