Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314046AbSDKNQW>; Thu, 11 Apr 2002 09:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314047AbSDKNQV>; Thu, 11 Apr 2002 09:16:21 -0400
Received: from ns.suse.de ([213.95.15.193]:28171 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314046AbSDKNQU>;
	Thu, 11 Apr 2002 09:16:20 -0400
Date: Thu, 11 Apr 2002 15:16:16 +0200
From: Andi Kleen <ak@suse.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "David S. Miller" <davem@redhat.com>, taka@valinux.co.jp, ak@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020411151616.A1239@wotan.suse.de>
In-Reply-To: <20020411.164134.85392767.taka@valinux.co.jp> <20020411.203823.67879801.taka@valinux.co.jp> <20020411.043614.02328218.davem@redhat.com> <200204111257.g3BCvOX10348@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 04:00:37PM -0200, Denis Vlasenko wrote:
> On 11 April 2002 09:36, David S. Miller wrote:
> > No, you must block truncate operations on the file until the client
> > ACK's the nfsd read request if you wish to use sendfile() with
> > nfsd.
> 
> Which shouldn't be a big performance problem unless I am unaware
> of some real-life applications doing heavy truncates.

Every unlink does a truncate. There are applications that delete files
a lot.

-Andi
