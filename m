Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVHWUmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVHWUmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVHWUmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:42:53 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:11646 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932388AbVHWUmw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:42:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LhKsbrXgYEeTgNNA5l/dmkQQVuyI4s2VGxudujE7s0BeYkyBDrooaM4JYsndC6H7CNr2b6nHYPYbJSdyf05wbIpUovFuG1hTZjfqjp83EhGshHgNL1cwFMeMHotr/mM2veB14cHmOOHpYIFDeika9bmDvomZMh569qgULiTawy8=
Message-ID: <b3f2685905082313423080e4e4@mail.gmail.com>
Date: Tue, 23 Aug 2005 22:42:51 +0200
From: Jari Sundell <sundell.software@gmail.com>
To: Davy Durham <pubaddr2@davyandbeth.com>
Subject: Re: select() efficiency / epoll
Cc: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <430B0E28.5090403@davyandbeth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42E162B6.2000602@davyandbeth.com>
	 <20050722212454.GB18988@outpost.ds9a.nl>
	 <430AF11A.5000303@davyandbeth.com>
	 <b3f2685905082312301868f00e@mail.gmail.com>
	 <430B0E28.5090403@davyandbeth.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/05, Davy Durham <pubaddr2@davyandbeth.com> wrote:

> Yes, that is what I was thinking and is why I mentioned that.  But I'm
> apparently not overwriting the pointers with FDs.. it seems that epoll
> is the cause at this point (unless I'm misusing the epoll API).  I've
> made some changes to now use select() instead of epoll and things work
> flawlessly (although it obviously won't work as efficiently when I
> really connect a lot of clients to this server)

I was hoping you would mention in your reply that you knew
epoll_data_t was an union and you didn't touch epoll_data::fd, so i
wouldn't have to say it explicitly. ;)

-- 
Rakshasa

Nyaa?
