Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVDSHYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVDSHYJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 03:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVDSHYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 03:24:09 -0400
Received: from Smtp2.univ-nantes.fr ([193.52.82.19]:4074 "EHLO
	smtp2.univ-nantes.fr") by vger.kernel.org with ESMTP
	id S261361AbVDSHXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 03:23:50 -0400
Message-ID: <4264B202.9080304@univ-nantes.fr>
Date: Tue, 19 Apr 2005 09:23:46 +0200
From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Organization: CRIUN
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: E1000 - page allocation failure - saga continues :(
References: <20050414214828.GB9591@mail.muni.cz> <4263A3B7.6010702@univ-nantes.fr> <20050418122202.GE26030@mail.muni.cz>
In-Reply-To: <20050418122202.GE26030@mail.muni.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek a écrit :

>On Mon, Apr 18, 2005 at 02:10:31PM +0200, Yann Dupont wrote:
>  
>
>>I have those problems too. The (temporary ?) fix is to raise the
>>min_free_kb to an higher value.
>>echo 65535 > /proc/sys/vm/min_free_kbytes
>>
>>Maybe such an high value is totally silly, but at least I don't have
>>those messages.
>>    
>>
>
>I know that kernel 2.6.6-bk4 works. So were there some memory manager changes
>since 2.6.6? If so it looks like there are some bugs. 
>On the other hand, ethernet driver should not allocate much memory but rather
>drop packets.
>
>Btw, are you using some TCP tweaks? E.g. I have default TCP window size 1MB.
>
>  
>
Do you have turned NAPI on ??? I tried without it off on e1000 and ...
surprise !
Don't have any messages since 12H now (usually I got those in less than 1H)

-- 
Yann Dupont, Cri de l'université de Nantes
Tel: 02.51.12.53.91 - Fax: 02.51.12.58.60 - Yann.Dupont@univ-nantes.fr

