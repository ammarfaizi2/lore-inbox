Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262523AbREUWpj>; Mon, 21 May 2001 18:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbREUWp3>; Mon, 21 May 2001 18:45:29 -0400
Received: from ABordeaux-102-1-1-162.abo.wanadoo.fr ([193.253.253.162]:9476
	"EHLO rayanne.dyndns.org") by vger.kernel.org with ESMTP
	id <S262523AbREUWpU>; Mon, 21 May 2001 18:45:20 -0400
Message-ID: <XFMail.20010522004456.petchema@concept-micro.com>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKCECOPDAA.davids@webmaster.com>
Date: Tue, 22 May 2001 00:44:56 +0200 (CEST)
Reply-To: petchema@concept-micro.com
Organization: Concept Micro
From: Pierre Etchemaite <petchema@concept-micro.com>
To: David Schwartz <davids@webmaster.com>
Subject: RE: tmpfs + sendfile bug ?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-May-2001 David Schwartz wrote:
> 
>> Any idea ?
> 
>       Looks like a bug in the program. If 'sendfile' returns 'EINVAL', that
means
> you can't use 'sendfile' to send this particular file, and should default to
> read/write or mmap/write. If this program doesn't, it doesn't understand
> Linux's 'sendfile' semantics.

Agreed, I came up to the same conclusion. Applications shouldn't assume that
sendfile will always work, and be ready to fall back to the traditional DIY
way of sending data.

I just downloaded more recent sources of proftpd (1.2.2rc2), and it looks
fixed, already... Time to upgrade :)

Regards,
Pierre.




