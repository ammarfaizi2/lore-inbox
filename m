Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269057AbUI2VWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269057AbUI2VWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbUI2VWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:22:17 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:50821 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S269057AbUI2VVl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:21:41 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2: isofs oops
Date: Wed, 29 Sep 2004 23:21:37 +0200
User-Agent: KMail/1.6.2
References: <200409292008.17149.bernd-schubert@web.de> <200409292245.58857.linux-kernel@borntraeger.net>
In-Reply-To: <200409292245.58857.linux-kernel@borntraeger.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409292321.38558.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 September 2004 22:45, you wrote:
> Bernd Schubert wrote:
> > ISO 9660 Extensions: RRIP_1991A
>
> [oops in isofs]
>
>
> Known and already fixed by Andrew Morton.
>
> --- a/fs/isofs/rock.c   2004-09-29 13:45:15 -07:00
> +++ b/fs/isofs/rock.c   2004-09-29 13:45:15 -07:00
> @@ -62,7 +62,7 @@
>  }
>
>  #define MAYBE_CONTINUE(LABEL,DEV) \
> -  {if (buffer) kfree(buffer); \
> +  {if (buffer) { kfree(buffer); buffer = NULL; } \
>    if (cont_extent){ \
>      int block, offset, offset1; \
>      struct buffer_head * pbh; \
>

Ah, thanks and sorry for the noise, after searching a bit more I found the 
previous thread.

Cheers,
	Bernd


-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
