Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313557AbSDMN7C>; Sat, 13 Apr 2002 09:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313578AbSDMN7C>; Sat, 13 Apr 2002 09:59:02 -0400
Received: from dialin-145-254-150-019.arcor-ip.net ([145.254.150.19]:15109
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S313557AbSDMN7B>; Sat, 13 Apr 2002 09:59:01 -0400
Message-ID: <3CB8396D.55A28D65@loewe-komp.de>
Date: Sat, 13 Apr 2002 15:58:05 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Anthony Chee <anthony.chee@polyu.edu.hk>
CC: linux-kernel@vger.kernel.org
Subject: Re: read proc entry
In-Reply-To: <000901c1e2f1$e65e9b00$0100a8c0@winxp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Chee wrote:
> 
> I written the following code in a module
> 
> static struct proc_dir_entry *test_proc;
> test_proc = create_proc_read_entry(test_proc, 0444, NULL, read_test_proc,
> NULL);
> 
> void show_kernel_message() {
>     printk("\nkernel test\n");
> }
> 
> int read_test_info(char* page, char** start, off_t off, int count, int* eof,
> void* data) {
>     show_kernel_message();

I think you have to signal EOF

	*eof=1;

> }
> 
> After I use "cat /proc/test_proc", it is found that there are three "kernel
> test" messages
> appear. Why it happened like this? I expected the message should be shown
> once.
>
