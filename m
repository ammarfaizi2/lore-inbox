Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135922AbRD0Ifs>; Fri, 27 Apr 2001 04:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135965AbRD0Ifh>; Fri, 27 Apr 2001 04:35:37 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:58793 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135922AbRD0IfW>; Fri, 27 Apr 2001 04:35:22 -0400
Date: Fri, 27 Apr 2001 10:35:19 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: Suggestion for module .init.{text,data} sections
Message-ID: <20010427103519.E679@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <200104270449.VAA05279@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200104270449.VAA05279@adam.yggdrasil.com>; from adam@yggdrasil.com on Thu, Apr 26, 2001 at 09:49:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 09:49:05PM -0700, Adam J. Richter wrote:
> 	A while ago, on linux-kernel, we had a discussion about
> adding support for __initdata and __init in modules.  Somebody
> (whose name escapes me) had implemented it by essentially adding
> a vmrealloc() facility in the kernel.  I think I've thought of a
> simpler way, that would require almost no kernel changes.
> 
[implementation details snipped]

While you are at this, you could make the .exit.{text,data}
sections swappable for modules (by allocating swappable pages fro
them?) and only mark them unswappable, while the module is
exiting.

Rationale: A device needed for swaping will never call exit
stuff, because it is still in use. So I see no obvious race here.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
