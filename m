Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277208AbRJINiE>; Tue, 9 Oct 2001 09:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277211AbRJINhy>; Tue, 9 Oct 2001 09:37:54 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:58127 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S277208AbRJINhq>;
	Tue, 9 Oct 2001 09:37:46 -0400
Date: Tue, 9 Oct 2001 10:37:56 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Kirill Ratkin <kratkin@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: No locking is needed ... why?
In-Reply-To: <20011009131357.60638.qmail@web11905.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33L.0110091036530.2847-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Kirill Ratkin wrote:

> Could somebody explain me this comment?:
> /*
>  * Incoming packets are placed on per-cpu queues so that
>  * no locking is needed.
>  */

> I didn't understand why packets are placed so and why
> locking isn't needed?

Each CPU has its own data structure here. This means no
other CPU will touch this queue (they have their own)
so there is nobody we could ever race against.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/


