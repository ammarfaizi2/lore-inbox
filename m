Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131070AbQK0OBv>; Mon, 27 Nov 2000 09:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131180AbQK0OBb>; Mon, 27 Nov 2000 09:01:31 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:48649 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S131070AbQK0OBT>;
        Mon, 27 Nov 2000 09:01:19 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Chad Schwartz <cwslist@main.cornernet.com>
cc: 64738 <schwung@rumms.uni-mannheim.de>, linux-kernel@vger.kernel.org
Subject: Re: Kernel bits 
In-Reply-To: Your message of "Mon, 27 Nov 2000 07:36:22 MDT."
             <Pine.LNX.4.30.0011270734470.20724-100000@main.cornernet.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Nov 2000 00:31:11 +1100
Message-ID: <2091.975331871@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000 07:36:22 -0600 (CST), 
Chad Schwartz <cwslist@main.cornernet.com> wrote:
>int main(void) {
>	printf("Size of an unsigned long is %d bytes\n",sizeof(unsigned long));
>	return(0);
>}
>
>That simple program will tell you that an unsigned long is 4 bytes, or 8
>bytes.
>
>It is then a safe assumption - that if you get back '8', that you're
>running a 64bit kernel, on a 64bit processor.

No, that only tells you the size of a long under the compiler you used.
If you are on an Intel IA64 (64 bit kernel) but you compile with gcc
for ix86 (32 bit userspace) then sizeof(long) is 4.  IA64 runs both
native and ix86 code, sizeof(any userspace field) tells you nothing
about the kernel.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
