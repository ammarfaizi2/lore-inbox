Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130020AbRBTLmt>; Tue, 20 Feb 2001 06:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130208AbRBTLmj>; Tue, 20 Feb 2001 06:42:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7944 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130020AbRBTLmW>; Tue, 20 Feb 2001 06:42:22 -0500
Subject: Re: [PATCH] new setprocuid syscall
To: peter@cadcamlab.org (Peter Samuelson)
Date: Tue, 20 Feb 2001 11:42:36 +0000 (GMT)
Cc: szabi@inf.elte.hu (BERECZ Szabolcs), linux-kernel@vger.kernel.org
In-Reply-To: <20010219230106.A23699@cadcamlab.org> from "Peter Samuelson" at Feb 19, 2001 11:01:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VBBn-0006Q5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (task)
> +		task->fsuid = task->euid = task->suid = task->uid = attr->ia_uid;
> +	read_unlock (&tasklist_lock);

There is an assumption in the kernel that only the task changes its own uid
and other related data.

Alan

