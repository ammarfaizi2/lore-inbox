Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVKWQmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVKWQmS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVKWQmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:42:18 -0500
Received: from web25813.mail.ukl.yahoo.com ([217.146.176.246]:37052 "HELO
	web25813.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932069AbVKWQmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:42:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Wztv01BVIcT3ESjOm5PPCgaWiqFtMCZA/CxS7AXWgwkIH/Vjvc7Yv+m6zy+OkBy4rvwNNrCxUoKiRPZAecZYq/ch2PpEgy6+i52WYgueXA4BxewAekMj03eiZOtS5zTkUVlVoQZKyS80jBq2CK5SHVAUbk7siMT8r2VqAv3gsYU=  ;
Message-ID: <20051123164215.12647.qmail@web25813.mail.ukl.yahoo.com>
Date: Wed, 23 Nov 2005 17:42:15 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: Use enum to declare errno values
To: Nikita Danilov <nikita@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17284.38866.189529.510004@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Nikita Danilov <nikita@clusterfs.com> a écrit :

> 
> (gdb) p (enum side)$1
> $2 = LEFT
> 
> (This works when debugging information about enum was stored in ELF
> object.)
> 

not really convenient. For example:

int foo(void)
{
        int tmp;

        tmp = bar();
        [...]
        return tmp;
}

How do you know if tmp store an errno value ? You have to look into bar and  so
on...By using "enum errnoval", gdb can directly tell you that a variable stores
an errno value.

Thanks


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
