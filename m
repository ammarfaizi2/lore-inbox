Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313540AbSDMNsh>; Sat, 13 Apr 2002 09:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313546AbSDMNsg>; Sat, 13 Apr 2002 09:48:36 -0400
Received: from smtp.polyu.edu.hk ([158.132.14.103]:55822 "EHLO
	hkpa04.polyu.edu.hk") by vger.kernel.org with ESMTP
	id <S313540AbSDMNsf>; Sat, 13 Apr 2002 09:48:35 -0400
Message-ID: <000901c1e2f1$e65e9b00$0100a8c0@winxp>
From: "Anthony Chee" <anthony.chee@polyu.edu.hk>
To: <linux-kernel@vger.kernel.org>
Subject: read proc entry
Date: Sat, 13 Apr 2002 21:48:31 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I written the following code in a module

static struct proc_dir_entry *test_proc;
test_proc = create_proc_read_entry(test_proc, 0444, NULL, read_test_proc,
NULL);

void show_kernel_message() {
    printk("\nkernel test\n");
}

int read_test_info(char* page, char** start, off_t off, int count, int* eof,
void* data) {
    show_kernel_message();
}

After I use "cat /proc/test_proc", it is found that there are three "kernel
test" messages
appear. Why it happened like this? I expected the message should be shown
once.

