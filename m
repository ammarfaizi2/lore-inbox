Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUFVREe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUFVREe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUFVREe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:04:34 -0400
Received: from holomorphy.com ([207.189.100.168]:62083 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264931AbUFVQUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 12:20:34 -0400
Date: Tue, 22 Jun 2004 09:19:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andre Marcos Dias Campos <amdias@cos.ufrj.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initialization of task_t
Message-ID: <20040622161954.GB2135@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andre Marcos Dias Campos <amdias@cos.ufrj.br>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0406221213320.14272-100000@cos1.cos.ufrj.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0406221213320.14272-100000@cos1.cos.ufrj.br>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 12:15:55PM -0300, Andre Marcos Dias Campos wrote:
> I would like to know where in the kernel code the task_t struct of each 
> process is initialized.
> Regards
> Andre Dias

You're looking for dup_task_struct(), which copies the child's from the
parent's, and static initialization of the first process with INIT_TASK,
defined in include/linux/init_task.h.


--- wli
