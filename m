Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289597AbSBNDJw>; Wed, 13 Feb 2002 22:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289598AbSBNDJm>; Wed, 13 Feb 2002 22:09:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25738 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289597AbSBNDJb>;
	Wed, 13 Feb 2002 22:09:31 -0500
Date: Wed, 13 Feb 2002 19:07:43 -0800 (PST)
Message-Id: <20020213.190743.66058963.davem@redhat.com>
To: raghuangadi@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: memory corruption in tcp bind hash buckets on SMP? 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020214005152.91108.qmail@web12306.mail.yahoo.com>
In-Reply-To: <20020212.221726.34760851.davem@redhat.com>
	<20020214005152.91108.qmail@web12306.mail.yahoo.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Raghu Angadi <raghuangadi@yahoo.com>
   Date: Wed, 13 Feb 2002 16:51:52 -0800 (PST)
   
   --- "David S. Miller" <davem@redhat.com> wrote:
   > 
   > This bug is fixed in the 2.4.9 Red Hat 7.2 errata kernels.
   
   Thanks, Is the following diff the only culprit/fix?
   
There are others, seatch for more instances of tcp_tw_get()
and tcp_tw_put() and things like atomic_set(tw->count, 1);
