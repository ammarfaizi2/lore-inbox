Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313415AbSDPAPl>; Mon, 15 Apr 2002 20:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSDPAPk>; Mon, 15 Apr 2002 20:15:40 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:58357
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313415AbSDPAPk>; Mon, 15 Apr 2002 20:15:40 -0400
Date: Mon, 15 Apr 2002 17:17:49 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andi Kleen <ak@suse.de>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        "David S. Miller" <davem@redhat.com>, taka@valinux.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020416001749.GY23513@matchmail.com>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	"David S. Miller" <davem@redhat.com>, taka@valinux.co.jp,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020411.164134.85392767.taka@valinux.co.jp> <20020411.203823.67879801.taka@valinux.co.jp> <20020411.043614.02328218.davem@redhat.com> <200204111257.g3BCvOX10348@Port.imtp.ilyichevsk.odessa.ua> <20020411151616.A1239@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 03:16:16PM +0200, Andi Kleen wrote:
> On Thu, Apr 11, 2002 at 04:00:37PM -0200, Denis Vlasenko wrote:
> > On 11 April 2002 09:36, David S. Miller wrote:
> > > No, you must block truncate operations on the file until the client
> > > ACK's the nfsd read request if you wish to use sendfile() with
> > > nfsd.
> > 
> > Which shouldn't be a big performance problem unless I am unaware
> > of some real-life applications doing heavy truncates.
> 
> Every unlink does a truncate. There are applications that delete files
> a lot.

Is this true at the filesystem level or only in memory?  If so, I could
immagine that it would make it much harder to undelete a file when you don't
even know how big it was (file set to 0 size)...

Why is this required?  Could someone say quickly (as I'm sure it's probably
quite complex) or point me to some references?
