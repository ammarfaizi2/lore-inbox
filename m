Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVCKWp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVCKWp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVCKWob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:44:31 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:56441 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261754AbVCKWmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:42:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TcuI4pFj8n0mtWt8hRSzspZDCK1w+NIYiGAxmT8qkSQhy2BvywzTrDhCtUa6XX4ksb6+IRLT1/gC2SMDrp5eEJAZEG4ieXiqW0dw2Q5ODG/u5QMmQ9jBPPdNxfiXfSQJzuxybELLsvUVtKTfSr6BUzpsCdtuqStaghacrsyu0yI=
Message-ID: <d120d50005031114422c144bcf@mail.gmail.com>
Date: Fri, 11 Mar 2005 17:42:46 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: AGP bogosities
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Dave Jones <davej@redhat.com>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <87vf7xg72s.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	 <20050311021248.GA20697@redhat.com>
	 <16944.65532.632559.277927@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org>
	 <87vf7xg72s.fsf@devron.myhome.or.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 12 Mar 2005 07:18:19 +0900, OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
> 
> +       if (!atomic_read(v)) {
> +               printk("BUG: atomic counter underflow at:\n");
> +               dump_stack();
> +       }

I wonder if adding "unlikely" might be beneficial here.

-- 
Dmitry
