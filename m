Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267152AbSLDXkT>; Wed, 4 Dec 2002 18:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267153AbSLDXkT>; Wed, 4 Dec 2002 18:40:19 -0500
Received: from earth.colorado-research.com ([65.171.192.8]:27054 "EHLO
	earth.colorado-research.com") by vger.kernel.org with ESMTP
	id <S267152AbSLDXkS>; Wed, 4 Dec 2002 18:40:18 -0500
Message-ID: <3DEE9425.40204@cora.nwra.com>
Date: Wed, 04 Dec 2002 16:47:49 -0700
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Flory <sflory@rackable.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS - IRIX client issues
References: <3DEE85D3.6070009@cora.nwra.com> <3DEE8EC2.2040305@rackable.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Flory wrote:

> Orion Poplawski wrote:
>
>> Hello -
>>
>>    I was wondering if there were and know NFS issues with IRIX 
>> clients?  I'm seeing a problem where an IRIX 6.5.17m client
>> accessing a linux 2.4.18 (redhat 7.2: -18.7.x) server will hang trying
>> to access a mount.  No traffic appears to make it to the server so it
>> appears to be locked up on the client end, but I don't know why.
>
>
>
>  Can you give a few more details?  Does the nfs share mount, or hang 
> at mounting?  What type of mount are you trying to do? (IE nfs v3 tcp, 
> or v2 udp)
>
>
> PS- Are you certain you aren't running iptables or ipchains? 
> "/etc/init.d/ipchains stop"  Also try mounting with out locking.  
> "mount foo:/foobar /mnt/nfs -onolock"  Have you tried nfs v2? "mount 
> -o nfsvers=2 foo:/foobar /mnt/nfs"
>
>
>
The mount comes up fine and works for quite a while and then crashes. 
 This is under relatively heavy load (tar files being unpacked, data 
files manipulated, etc.).  No iptables/chains.

The mount is automounted,  the resulting mtab entry on IRIX is:

lego:/export/turb3 /data/turb3 nfs vers=3,rw,dev=100007 0 0

I believe the mount is UDP,  I'm not specifying any special options.

I'll look into trying nolock and v2.  SHould I try TCP?

- Orion




