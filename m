Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293408AbSCKATP>; Sun, 10 Mar 2002 19:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293407AbSCKATF>; Sun, 10 Mar 2002 19:19:05 -0500
Received: from ns.ithnet.com ([217.64.64.10]:5133 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S293403AbSCKASv>;
	Sun, 10 Mar 2002 19:18:51 -0500
Message-Id: <200203110018.BAA11921@webserver.ithnet.com>
From: Stephan von Krawczynski <skraw@ithnet.com>
Date: Mon, 11 Mar 2002 01:18:48 +0100
Content-Transfer-Encoding: 7BIT
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
To: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no>
MIME-Version: 1.0
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>>> " " == Stephan von Krawczynski <skraw@ithnet.com> writes:     
>                                                                     
>      > Hello all, I just upgraded a host from 2.2.19 to 2.2.21-pre3 
>      > and discovered a problem with kernel nfs. Setup is this:     
>                                                                     
>      > knfs-server is 2.4.19-pre2 knfs-client is 2.2.21-pre3        
>                                                                     
>      > First mount some fs (mountpoint /backup). Then go and mount  
>      > some other fs from the same server (mountpoint /mnt), do some
>      > i/o on the latter and umount it again. Now try to access     
>      > /backup. You see:                                            
>      > 1) /backup (as a fs) vanished, you get a stale nfs handle.   
>      > 2) umount /backup; mount /backup does not work. client tells 
>      >    "permission denied". server tells "rpc.mountd: getfh      
failed:                                                               
>      >    Operation not permitted"                                  
>                                                                     
> By 'some fs' do you mean ext2?                                      
>                                                                     
> Not all filesystems work well with knfsd when things start to drop  
out                                                                   
> of the (d|i)caches. In particular things like /backup == VFAT might 
> give the above behaviour, since VFAT does not know how to map the   
NFS                                                                   
> file handles into on-disk inodes.                                   
                                                                      
Sorry Trond,                                                          
                                                                      
this is a weak try of an explanation. All involved fs types are       
reiserfs. The problem occurs reproducably only after (and including)  
2.2.20 and above and _not_ in 2.2.19. There must be some problem.     
Though I do not know whether the problem is on the client side, or    
simply produced by this client side and effectively located on 2.4.18 
server, I really can't tell. But giving me something to try might     
clear the picture.                                                    
                                                                      
Any hints?                                                            
                                                                      
Stephan                                                               
                                                                      
                                                                      
