Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312634AbSDKRgM>; Thu, 11 Apr 2002 13:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312638AbSDKRgL>; Thu, 11 Apr 2002 13:36:11 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:34042 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S312634AbSDKRgL>; Thu, 11 Apr 2002 13:36:11 -0400
Date: Thu, 11 Apr 2002 13:36:10 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020411133610.C20895@redhat.com>
In-Reply-To: <20020411.164134.85392767.taka@valinux.co.jp> <20020411.203823.67879801.taka@valinux.co.jp> <20020411.043614.02328218.davem@redhat.com> <200204111257.g3BCvOX10348@Port.imtp.ilyichevsk.odessa.ua> <20020411151616.A1239@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
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

Not quite.  The implicite truncate only happens when the link count falls 
to 0 and the last user of the inode releases their reference to the inode.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
