Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVF0H1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVF0H1d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVF0H0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:26:05 -0400
Received: from [213.170.72.194] ([213.170.72.194]:14295 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261704AbVF0HYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 03:24:33 -0400
Message-ID: <42BFA9AD.5090000@yandex.ru>
Date: Mon, 27 Jun 2005 11:24:29 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: David Masover <ninja@slaphack.com>, Hubert Chan <hubert@uhoreg.ca>,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <87y88webpo.fsf@evinrude.uhoreg.ca> <200506270459.j5R4xdZp005659@turing-police.cc.vt.edu>            <42BF9489.9080202@slaphack.com> <200506270624.j5R6OWFn008836@turing-police.cc.vt.edu>
In-Reply-To: <200506270624.j5R6OWFn008836@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> For more fun, consider how you can write 1 megabyte of data to a file,
> lseek to the beginning and start writing again - and you go over quota
> on the *second* write even though you're over-writing already existing
> data.  Can happen if you're compressing, and the second write doesn't
> compress as well as the first. (To be fair, we already have similar
> issues with sparse files - but at least 'tar --sparse' has an easy way
> to deal with it compared to this. ;)
Sorry, may be I'm out of the context, but here is my view.

In case of compression in the kernel space you may take into account the 
size of file in the _uncompressed_ form and how much it takes in the 
compressed form - doesn't matter. So, no problems with rewriting.

Moreover, are you sure that the current quota model is enough for FSes 
with on-fligh compression? The model should probably be extended/changed.

Problems with quota and accounting is not the reason to forbid the 
on-flight compression. And they don't have to co-exist well.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
