Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbTCZWHW>; Wed, 26 Mar 2003 17:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbTCZWHV>; Wed, 26 Mar 2003 17:07:21 -0500
Received: from mail.hometree.net ([212.34.181.120]:46004 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S262580AbTCZWHV>; Wed, 26 Mar 2003 17:07:21 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH] s390 update (4/9): common i/o layer update.
Date: Wed, 26 Mar 2003 22:18:32 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b5t8vo$g1b$1@tangens.hometree.net>
References: <200303261610.16448.schwidefsky@de.ibm.com> <20030326160810.A17984@infradead.org>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1048717112 16427 212.34.181.4 (26 Mar 2003 22:18:32 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 26 Mar 2003 22:18:32 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

>Yikes!  Please use the actual type here instead of typeof()

>> +	if (sch->lpm == 0)
>> +		return -ENODEV;
>> +	else
>> +		return -EACCES;

>I'd write this as return (sch->lpm ? -EACCES : -ENODEV), but maybe I'm
>just too picky..

Ah, don't be shy. Real men write this as

	return -(sch->lpm ? EACCES : ENODEV); 


	:-)
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
