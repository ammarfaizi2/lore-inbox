Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271399AbRINWzh>; Fri, 14 Sep 2001 18:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271421AbRINWz2>; Fri, 14 Sep 2001 18:55:28 -0400
Received: from jalon.able.es ([212.97.163.2]:10192 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S271399AbRINWzV>;
	Fri, 14 Sep 2001 18:55:21 -0400
Date: Sat, 15 Sep 2001 00:55:38 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Andreas Schwab <schwab@suse.de>
Cc: Alexander Stohr <AlexanderS@ati.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre9 min/max raises "const" warnings
Message-ID: <20010915005538.A1589@werewolf.able.es>
In-Reply-To: <761E23C7F09AD51188990008C74C26141221@fgl00exh01.atitech.com> <jeelp9vbzn.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <jeelp9vbzn.fsf@sykes.suse.de>; from schwab@suse.de on Fri, Sep 14, 2001 at 20:55:08 +0200
X-Mailer: Balsa 1.2.pre3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010914 Andreas Schwab wrote:
>Alexander Stohr <AlexanderS@ati.com> writes:
>
>|> i am yet not sure if the used "? :" operator set does qualify as
>|> a left-value.
>
>For Standard C it isn't, but for GNU C it is.
>

Perhaps it is nonsense, but, as the kernel already uses gcc-specific features,
the gcc folks could extend to C th '<?' and '>?' operators from C++, so

#define max(a,b) (a >? b)
#define min(a,b) (a <? b)

It works at least since 2.95.2. gcc3 warns about signs in -Wall mode.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.9-ac10 #1 SMP Sat Sep 8 02:27:41 CEST 2001 i686
