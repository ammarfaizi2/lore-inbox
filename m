Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313585AbSDMOHx>; Sat, 13 Apr 2002 10:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313586AbSDMOHw>; Sat, 13 Apr 2002 10:07:52 -0400
Received: from smtp.polyu.edu.hk ([158.132.14.103]:42256 "EHLO
	hkpa04.polyu.edu.hk") by vger.kernel.org with ESMTP
	id <S313585AbSDMOHu>; Sat, 13 Apr 2002 10:07:50 -0400
Message-ID: <002001c1e2f4$983f7e00$0100a8c0@winxp>
From: "Anthony Chee" <anthony.chee@polyu.edu.hk>
To: =?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <000901c1e2f1$e65e9b00$0100a8c0@winxp> <3CB8396D.55A28D65@loewe-komp.de>
Subject: Re: read proc entry
Date: Sat, 13 Apr 2002 22:07:48 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After I added *eof =1, that message appears two times. How can I reduce it
only one?

----- Original Message -----
From: "Peter Wächtler" <pwaechtler@loewe-komp.de>
To: "Anthony Chee" <anthony.chee@polyu.edu.hk>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, April 13, 2002 9:58 PM
Subject: Re: read proc entry


> Anthony Chee wrote:
> >
> > I written the following code in a module
> >
> > static struct proc_dir_entry *test_proc;
> > test_proc = create_proc_read_entry(test_proc, 0444, NULL,
read_test_proc,
> > NULL);
> >
> > void show_kernel_message() {
> >     printk("\nkernel test\n");
> > }
> >
> > int read_test_info(char* page, char** start, off_t off, int count, int*
eof,
> > void* data) {
> >     show_kernel_message();
>
> I think you have to signal EOF
>
> *eof=1;
>
> > }
> >
> > After I use "cat /proc/test_proc", it is found that there are three
"kernel
> > test" messages
> > appear. Why it happened like this? I expected the message should be
shown
> > once.
> >
>

