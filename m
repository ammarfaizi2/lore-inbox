Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293131AbSDEKzs>; Fri, 5 Apr 2002 05:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312465AbSDEKz3>; Fri, 5 Apr 2002 05:55:29 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:45953 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S312464AbSDEKzS>; Fri, 5 Apr 2002 05:55:18 -0500
Date: Fri, 5 Apr 2002 12:55:09 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: socket write(2) after remote shutdown(2) problem ?
Message-ID: <20020405105509.GE16595@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020405095038.GB16595@come.alcove-fr> <20020405.020443.115246313.davem@redhat.com> <20020405104733.GD16595@come.alcove-fr> <20020405.024435.88131177.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 02:44:35AM -0800, David S. Miller wrote:

>    > Your client does not do any write()'s after the shutdown call.
>    > It simply exit(0)'s.
>    
>    You mean the 'server' ? Even if I add a sleep(600) between the 
>    shutdown() call and the exit() call I get the same behaviour.
> 
> Oh I see now.  Here is what should happen:
> 
> 	* server shutdown(ALL)
> 	* the write() should succeed on the client

So this is really supposed to succeed then... Somewhat illogical to
me...

> 	* client socket receives a TCP reset

How is the client socket supposed to know it received a TCP reset
(I am talking from the application point of view, not the kernel...) ?

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
