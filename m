Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285516AbRLYNJz>; Tue, 25 Dec 2001 08:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285517AbRLYNJp>; Tue, 25 Dec 2001 08:09:45 -0500
Received: from mons.uio.no ([129.240.130.14]:20922 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S285516AbRLYNJ0>;
	Tue, 25 Dec 2001 08:09:26 -0500
To: Amber Palekar <amber_palekar@yahoo.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: syscall from modules
In-Reply-To: <20011225113140.35274.qmail@web20303.mail.yahoo.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 25 Dec 2001 14:09:19 +0100
In-Reply-To: <20011225113140.35274.qmail@web20303.mail.yahoo.com>
Message-ID: <shssn9zv43k.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Amber Palekar <amber_palekar@yahoo.com> writes:

     >  Hi,
     >    I am trying to write a linux kernel module.I want
     >  to use sys_sendto,sys_recvfrom etc calls from the
     >  module.However these symbols are not present in 'ksyms'.One
     >  sluggish option is to modify socket.c ( which contains these
     >  function definitions ) to export the symbols. However this
     >  would require
     > comiling the entire kernel.Is there a descent way to do this ??

Hi,

Just use sock_sendmsg() and sock_recvmsg() directly. They are both
exported in netsyms.c.

Cheers,
  Trond
