Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292770AbSBUUpt>; Thu, 21 Feb 2002 15:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292769AbSBUUpk>; Thu, 21 Feb 2002 15:45:40 -0500
Received: from smi-105.smith.uml.edu ([129.63.206.105]:54021 "HELO
	smi-105.smith.uml.edu") by vger.kernel.org with SMTP
	id <S292767AbSBUUpT>; Thu, 21 Feb 2002 15:45:19 -0500
Date: Thu, 21 Feb 2002 15:45:18 -0500
From: Alex Pennace <alex@pennace.org>
To: Jason Yan <jasonyanjk@yahoo.com>
Cc: "linux-kernel @ vger. kernel. org" <linux-kernel@vger.kernel.org>
Subject: Re: Is there any story about the magic number 0x08048000 in  "ld" internal linker script ?
Message-ID: <20020221204518.GA27989@buick.pennace.org>
Mail-Followup-To: Jason Yan <jasonyanjk@yahoo.com>,
	"linux-kernel @ vger. kernel. org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020220215605.KXU6407.tomts21-srv.bellnexxia.net@abc337>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020220215605.KXU6407.tomts21-srv.bellnexxia.net@abc337>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 04:55:26PM -0800, Jason Yan wrote:
> Hi,
> 
> When I use gdb to trace/debug my program, I notice that the programe linear address always start from 0x8048xxx, then I use "ld --verbose" to display the internal linker script, I find an interesting address 0x08048000 :
> 
> SECTIONS
> {
>   /* Read-only sections, merged into text segment: */
>   . = 0x08048000 + SIZEOF_HEADERS
>   ......snip....
> 
> that's where 0x8048xxx comes from. I'm just curious, why 0x08048000 not other number? Any story?

0x8048000 is the typical starting point for the text segment according
to the System V Intel 386 ABI specification
(<http://stage.caldera.com/developer/devspecs/abi386-4.pdf>).
