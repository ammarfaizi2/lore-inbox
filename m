Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUFYHwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUFYHwO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 03:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266297AbUFYHwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 03:52:14 -0400
Received: from www02.ies.inet6.fr ([62.210.153.202]:27852 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S266295AbUFYHwL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 03:52:11 -0400
Message-ID: <40DBD9AD.8070503@inet6.fr>
Date: Fri, 25 Jun 2004 09:52:13 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040519)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: alan <alan@clueserver.org>, "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org, Amit Gud <gud@eth.net>
Subject: Re: Elastic Quota File System (EQFS)
References: <20040624213041.GA20649@elf.ucw.cz> <Pine.LNX.4.44.0406241347560.18047-100000@www.fnordora.org> <20040624220318.GE20649@elf.ucw.cz>
In-Reply-To: <20040624220318.GE20649@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Trusted: [ ip=62.210.105.37 rdns=ppp3290-cwdsl.fr.cw.net 
	helo=proxy.inet6-interne.fr by=smtp.ies.inet6.fr ident= ] [ 
	ip=192.168.55.3 rdns=192.168.55.3 helo=!192.168.55.3! 
	by=proxy.inet6-interne.fr ident= ]
X-Spam-DCC: dcc.uncw.edu: web02.inet6.ies 1201; Body=1 Fuz1=1 Fuz2=1
X-Spam-Assassin: No hits=0.0 required=4.5
X-Spam-Untrusted: 
X-Spam-Pyzor: Reported 0 times.
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote the following on 06/25/2004 12:03 AM :

>Of course, if mozilla marked them "elastic" it should better be
>prepared for they disappearance. I'd disappear them with simple
>unlink(), so they'd physically survive as long as someone held them
>open.
>
>  
>

Doesn't work reliably : the deletion is done in order to reclaim space 
that is needed now. You may want to retry unlinking files until you 
reach the free space needed, but this is clearly a receipe for famine : 
process can wait on writes an unspecified amount of time.


-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 

