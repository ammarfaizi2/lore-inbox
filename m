Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbSLWWEU>; Mon, 23 Dec 2002 17:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbSLWWEU>; Mon, 23 Dec 2002 17:04:20 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:55457 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S266986AbSLWWET> convert rfc822-to-8bit; Mon, 23 Dec 2002 17:04:19 -0500
Subject: RE: PAGE = 1k
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: User & <breno_silva@beta.bandnet.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021223165245.M26209@beta.bandnet.com.br>
References: <20021223165245.M26209@beta.bandnet.com.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Dec 2002 00:12:21 +0200
Message-Id: <1040681542.5839.8.camel@gby.benyossef.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-23 at 18:52, User & wrote:


> yes i know ,it´s depend of hardware, but maybe we can do something as mmu
> with software or something like this , i don´t know.

No, but you can fake it ;-)

I'm taking a wild guess here that you're interested in this subject
because of distributed shared memory. That is, you're interested in
smaller page sizes because you want to be aware of changes done to
memory structures in sizes smaller then a page. 

If so, you might want to check out how the Millipede system from the
Technion works - it basically creates several "views" of a page using
segmentation and other MMU features which creates artifical locality of
memory structures on the same page in units smaller then a hardware
page. 

Hope this helps,
Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com

 "Geeks rock bands cool name #8192: RAID against the machine"

