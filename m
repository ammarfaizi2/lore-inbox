Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbTKZUck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbTKZUck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:32:40 -0500
Received: from holomorphy.com ([199.26.172.102]:26558 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264303AbTKZUcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:32:39 -0500
Date: Wed, 26 Nov 2003 12:32:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amanda vs 2.6
Message-ID: <20031126203231.GV8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <200311261443.43695.gene.heskett@verizon.net> <20031126195049.GT8039@holomorphy.com> <200311261523.33524.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311261523.33524.gene.heskett@verizon.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 November 2003 14:50, William Lee Irwin III wrote:
>> Okay, then we need to figure out what the hung process was doing.
>> Can you find its pid and check /proc/$PID/wchan?

On Wed, Nov 26, 2003 at 03:23:33PM -0500, Gene Heskett wrote:
> Ok, repeat, us is PID 1843, so:
> [root@coyote root]# ps -ea|grep su
>  1843 pts/1    00:00:00 su
> [root@coyote root]# cat /proc/1843/wchan
> sys_wait4[root@coyote root]#
> Unforch, echoing a 0 to that variable doesn't fix it, reboot time 
> again.
> Do you need my .config?

su had apparently spawned something and is waiting on it in the
wchan you showed. Could you find the shell it spawned as an amanda
user and syslogd (as per Linus' suggestion) also?


-- wli
