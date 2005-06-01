Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVFAHGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVFAHGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 03:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVFAHGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 03:06:38 -0400
Received: from lns-vlq-17f-81-56-169-232.adsl.proxad.net ([81.56.169.232]:14471
	"EHLO lns-vlq-17f-81-56-169-232.adsl.proxad.net") by vger.kernel.org
	with ESMTP id S261306AbVFAHGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 03:06:36 -0400
Message-ID: <429D5E79.2010707@unice.fr>
Date: Wed, 01 Jun 2005 09:06:33 +0200
From: XIAO Gang <xiao@unice.fr>
Organization: =?ISO-8859-1?Q?Universit=E9_de_Nice_-_Sophia_Anti?=
 =?ISO-8859-1?Q?polis?=
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, fr, zh-CN, zh-TW
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Suggestion on "int len" sanity
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would like to make a security suggestion.

There are many length variables in the kernel, locally declared as "len" 
or "length", either as "int", "unsigned int" or "size_t". However, 
declaring a length as "int" leads easily to an erroneous situation, as 
the author (or even a code checker) might make the implicite hypothesis 
that the length is positive, so that it is enough to make a sanity check 
of the kind

if (length > limit) ERROR;

which is not enough.

On the other hand, when a variable is named "len" or "length", it is 
usually used for length and never should go negative. So could I suggest 
that the declarations of these variables to be uniformized to "size_t", 
via a gradual but sysmatic cleanup?

-- 

XIAO Gang (~{P$8U~})                          xiao@unice.fr
          home page: pcmath126.unice.fr/xiao.html 



