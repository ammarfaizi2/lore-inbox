Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbSJWVnU>; Wed, 23 Oct 2002 17:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbSJWVnT>; Wed, 23 Oct 2002 17:43:19 -0400
Received: from marc2.theaimsgroup.com ([63.238.77.172]:59408 "EHLO
	marc2.theaimsgroup.com") by vger.kernel.org with ESMTP
	id <S265242AbSJWVnT>; Wed, 23 Oct 2002 17:43:19 -0400
Date: Wed, 23 Oct 2002 17:49:29 -0400
Message-Id: <200210232149.g9NLnT611850@marc2.theaimsgroup.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: One for the Security Guru's
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-23, "Robert L. Harris" <Robert.L.Harris@rdlg.net> wrote:   
   
>   The consultants aparantly told the company admins that kernel modules   
> were a massive security hole and extremely easy targets for root kits.   
   
Massive?  Of course not.  Easy target for root kits, sure, but only if 
they've already been owned, first.  Under normal circumstances (there 
have been bugs in the past; iirc in kerneld for instance which let a user 
trick the system into loading an arbitrary file as a module) one can't 
load modules until one's already root, so the system would have had to be 
compromised already.  Trojaning the kernel is the best place for a  
rootkit to live; why bother replacing individual tools (and hoping you  
got them all, and that there's no static-linked integrity checker  
somewhere) when you can just modify opendir(2), even read(2), etc to lie  
for you?   
  
4-5 years ago I would have (and did) recommend staying away from modular   
kernels for this reason.  But binary-patching a running non-modular  
kernel has been well explored and is well-known; it's really no harder to 
trojan a non-modular kernel than a modular one.  Assuming you have not 
taken steps to disallow raw io, /dev/kmem access, etc.  If you are 
willing/able to do that, then you can just insmod all necessary modules, 
and then another one which disables further module-loading, drop the 
necessary capabilities systemwide, etc.  So again, modular/nonmodular 
kernel doesn't matter much.  
   
--   
Hank Leininger <hlein@progressive-comp.com>    
     
