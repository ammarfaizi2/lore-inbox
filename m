Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbSJQXRf>; Thu, 17 Oct 2002 19:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262346AbSJQXRf>; Thu, 17 Oct 2002 19:17:35 -0400
Received: from code.and.org ([63.113.167.33]:47314 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S262326AbSJQXRe>;
	Thu, 17 Oct 2002 19:17:34 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: matti.aarnio@zmailer.org, zilvinas@gemtek.lt, linux-kernel@vger.kernel.org
Subject: Re: sendfile(2) behaviour has changed ?
References: <20021016091046.GD9644@mea-ext.zmailer.org>
	<20021016.025935.132073102.davem@redhat.com>
	<m3it00zt4d.fsf@code.and.org>
	<20021017.154138.130141726.davem@redhat.com>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 17 Oct 2002 19:23:10 -0400
In-Reply-To: <20021017.154138.130141726.davem@redhat.com>
Message-ID: <m3r8eoy7j5.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>    From: James Antill <james@and.org>
>    Date: 17 Oct 2002 16:51:30 -0400
> 
>     It really needs a new interface for recvfile/copyfile/whatever
>    anyway, as you can only specify an off_t for the from fd at present.
>    
> Ummm, you can use lseek() on the 'to' fd perhaps?

 On the client side it's pretty useful to be able to write into the
same file from the network from multiple connections.

 You could say that you are much more likely to have multiple
connections reading from one file than have them writing to the
same file on the server, but then there the errno problem is much more
obvious.

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
