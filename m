Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVF2T1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVF2T1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 15:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVF2T1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 15:27:43 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:18313 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262447AbVF2T1k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 15:27:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UesnLJo01FOC+RWd0UlvxkD6Ngwp3OwOHVLWolxP/ViHwyOFtwZs3V1bgqcsjhO8yMEFQFKwU9WQgxX977mU93Y+lDxfldcpHeraiV07m2ZRX/jlWCb7dNe+t7vVOM1n+lA4MwBCUUB094Rlg7sLB9V6kDqgRQvMdZ5AsABHPgo=
Message-ID: <9a874849050629122775d0542c@mail.gmail.com>
Date: Wed, 29 Jun 2005 21:27:40 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: =?ISO-8859-1?Q?Gustavo_Guillermo_P=E9rez?= <gustavo@compunauta.com>
Subject: Re: [OT] build just one driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200506282309.20296.gustavo@compunauta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200506282309.20296.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/05, Gustavo Guillermo Pérez <gustavo@compunauta.com> wrote:
> How can I build just one driver without building everthing or removing the
> others from the config.
> 
> If I do make clean to save space, and if I need to build just 1 driver after.
> 

See "make help" : 

$ make help | grep "dir/"
  dir/            - Build all files in dir and below
  dir/file.[ois]  - Build specified target only


So, as you can see, typing
  make drivers/net/
for example, will build everything in the drivers/net/ dir (and
subdirs), and if you type
  make drivers/scsi/aic7xxx/aic7xxx.o
It will build just that one object file...


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
