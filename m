Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131498AbRC0T2l>; Tue, 27 Mar 2001 14:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbRC0T2c>; Tue, 27 Mar 2001 14:28:32 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:44553 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131498AbRC0T2Z>;
	Tue, 27 Mar 2001 14:28:25 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103271927.f2RJRGV55509@saturn.cs.uml.edu>
Subject: Re: Larger dev_t
To: Andries.Brouwer@cwi.nl
Date: Tue, 27 Mar 2001 14:27:16 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, hpa@transmeta.com
In-Reply-To: <UTC200103270929.LAA29224.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at Mar 27, 2001 11:29:20 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl writes:
> [Linus Torvalds]

>> You'e now forced every piece of code that needs a dev_t
>> to carry along the overhead of having a 64-bit field
>
> Let me repeat: there is no such code. In user space dev_t already is
> 64 bits, whether you like it or not. We cannot go back to libc5.
...
> In other words, inside the kernel the normal obvious coding will
> give us ints major, minor. Outside the kernel we have a 64-bit dev_t.
...
> But while dev_t already is 64-bits in user space, the same does not

In your dreams!!!!

int c_has_loose_type_checking(char *name){
  struct stat sbuf;
  /* ... */
  return sbuf.st_rdev;
}

Then we have NFSv2, archive file formats, and zillions of
little tools.

I enjoy truncating dev_t to a reasonable size. Sometimes I check
my input arguments for illogically huge values, and other times I
just relish the opportunity to inflict data loss on you personally.

