Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263106AbREWOkF>; Wed, 23 May 2001 10:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263108AbREWOjz>; Wed, 23 May 2001 10:39:55 -0400
Received: from ns.suse.de ([213.95.15.193]:35087 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263106AbREWOjj>;
	Wed, 23 May 2001 10:39:39 -0400
Date: Wed, 23 May 2001 16:38:43 +0200
From: Andi Kleen <ak@suse.de>
To: sebastien person <sebastien.person@sycomore.fr>
Cc: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: [timer] max timeout
Message-ID: <20010523163843.A24721@gruyere.muc.suse.de>
In-Reply-To: <20010523162801.38dabdff.sebastien.person@sycomore.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010523162801.38dabdff.sebastien.person@sycomore.fr>; from sebastien.person@sycomore.fr on Wed, May 23, 2001 at 04:28:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 04:28:01PM +0200, sebastien person wrote:
> Is it bad to do the following call ?
> 
> 	mod_timer(&timer, jiffies+(0.1*HZ));

Yes very bad. gcc will generate a floating point add for that, corrupting
the user process' floating point context. 


-Andi

