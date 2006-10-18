Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422756AbWJRSh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422756AbWJRSh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161265AbWJRSh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:37:28 -0400
Received: from pat.uio.no ([129.240.10.4]:3769 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161264AbWJRSh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:37:27 -0400
Subject: Re: NFS inconsistent behaviour
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: Mohit Katiyar <katiyar.mohit@gmail.com>, linux-kernel@vger.kernel.org,
       Linux NFS mailing list <nfs@lists.sourceforge.net>
In-Reply-To: <1161194229.6095.81.camel@lade.trondhjem.org>
References: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com>
	 <46465bb30610160013v47524589g39c61465b5955f65@mail.gmail.com>
	 <20061016084656.GA13292@janus>
	 <46465bb30610160235m211910b6g2eb074aa23060aa9@mail.gmail.com>
	 <20061016093904.GA13866@janus>
	 <46465bb30610171822h3f747069ge9a170f1759af645@mail.gmail.com>
	 <20061018063945.GA5917@janus> <1161194229.6095.81.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 14:37:12 -0400
Message-Id: <1161196632.6095.94.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.56, required 12,
	autolearn=disabled, AWL 1.44, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 13:57 -0400, Trond Myklebust wrote:
> Note also that you _can_ change the range of ports used by the NFS
> client itself at least. Just edit /proc/sys/sunrpc/{min,max}_resvport.
> On the server side, you can use the 'insecure' option in order to allow
> mounts that originate from non-privileged ports (i.e. port > 1024).
> If you are using strong authentication (for instance RPCSEC_GSS/krb5)
> then that actually makes a lot of sense, since the only reason for the
> privileged port requirement was to disallow unprivileged NFS clients.

Oops... Something got lost there. That last sentence should read

        ...since the only reason for the privileged port requirement was
        to disallow unprivileged NFS clients that could be used to spoof
        other user identities via the weak AUTH_SYS authentication.

Cheers,
  Trond

