Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290464AbSAQVMb>; Thu, 17 Jan 2002 16:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290465AbSAQVMU>; Thu, 17 Jan 2002 16:12:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55691 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290464AbSAQVMK>;
	Thu, 17 Jan 2002 16:12:10 -0500
Date: Thu, 17 Jan 2002 13:11:01 -0800 (PST)
Message-Id: <20020117.131101.118630373.davem@redhat.com>
To: balbir_soni@hotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Suspected bug in getpeername and getsockname
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <F96rPJjUsZ6G7KCk5sm0001ad67@hotmail.com>
In-Reply-To: <F96rPJjUsZ6G7KCk5sm0001ad67@hotmail.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Balbir Singh" <balbir_soni@hotmail.com>
   Date: Thu, 17 Jan 2002 08:27:17 -0800

   What I was trying to state is that the protocol specific
   code does not get to see the length passed from the user.
   The protocol specific code would like to look at what
   the user passed.
   
If move_addr_to_user() takes care of all of the issues, there is no
reason for the protocol specific code to know anything about the
user's len at all.

You have to show me a purpose for it to get passed down.  What would
it get used for?  All the protocol specific could should (and does)
do is provide the data back to the top level routine and
move_addr_to_user() takes care of the remaining details.
