Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262218AbSJ2SO3>; Tue, 29 Oct 2002 13:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSJ2SO2>; Tue, 29 Oct 2002 13:14:28 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:33022 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262218AbSJ2SOK>;
	Tue, 29 Oct 2002 13:14:10 -0500
From: Badari Pulavarty <badari@us.ibm.com>
Message-Id: <200210291819.g9TIJvO16528@eng2.beaverton.ibm.com>
Subject: [RFC] generic_file_direct_IO() argument changes for AIO
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org (lkml)
Date: Tue, 29 Oct 2002 10:19:56 -0800 (PST)
Cc: cel@citi.umich.edu, akpm@digeo.com, badari@us.ibm.com (Badari Pulavarty)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Inorder to support AIO for raw/O_DIRECT, I need to add "struct kiocb *"
to generic_file_direct_IO() and all direct_IO() ops.

generic_file_direct_IO(int rw, struct file *file, const struct iovec *iov,
        loff_t offset, unsigned long nr_segs)

Instead of adding a new argument, I propose replace 

	"struct file *file" argument with "struct kiocb *iocb"

One can get "filp" from iocb->ki_filp.

Any objections ?

Thanks,
Badari
