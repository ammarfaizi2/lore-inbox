Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318993AbSIJGDo>; Tue, 10 Sep 2002 02:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319040AbSIJGDo>; Tue, 10 Sep 2002 02:03:44 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:54007 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S318993AbSIJGDo>; Tue, 10 Sep 2002 02:03:44 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E17oYth-0006wD-00@starship> 
References: <E17oYth-0006wD-00@starship>  <2653.1031563253@redhat.com> 
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] On paging of kernel VM. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 10 Sep 2002 07:08:27 +0100
Message-ID: <16751.1031638107@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


phillips@arcor.de said:
>  Why can't you go per-architecture and fall back to the slow way of
> doing it for architectures that don't have the new functionality yet? 

No. We can't make this kind of change to the way the vmalloc region works on
some architectures only. It has to remain uniform.

Either it's worth doing for all, or it's not. It's a fairly trivial change
in the slow path, after all. I suspect it's worth it -- I'll ask the same 
question again with a patch attached as soon as I get time, in order to 
elicit more responses.

--
dwmw2


