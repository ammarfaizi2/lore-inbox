Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313633AbSDPIac>; Tue, 16 Apr 2002 04:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313634AbSDPIab>; Tue, 16 Apr 2002 04:30:31 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:16512 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313633AbSDPIaa>;
	Tue, 16 Apr 2002 04:30:30 -0400
Date: Tue, 16 Apr 2002 10:30:01 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
Message-ID: <20020416103001.A32435@ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com> <3CBBCD31.4090105@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 09:05:21AM +0200, Martin Dalecki wrote:
> Tue Apr 16 01:02:47 CEST 2002 ide-clean-36
> 
> - Consolidate ide_choose_drive() and choose_drive() in to one function.
> 
> - Remove sector data byteswpapping support. Byte-swapping the data is supported
>    on the file-system level where applicable.  Byte-swapped interfaces are
>    supported on a lower level anyway. And finally it was used inconsistently.

Are you sure about this? I think file systems support LE/BE, but not
byteswapping because of IDE being LE on a BE system.

> - Eliminate taskfile_input_data() and taskfile_output_data(). This allowed us
>    to split up ideproc and eliminate the ugly action switch as well as the
>    corresponding defines.
> 
> - Remove tons of unnecessary typedefs from ide.h
> 
> - Prepate the PIO read write code for soon overhaul.
> 
> - Misc small bits here and there :-).
> 

-- 
Vojtech Pavlik
SuSE Labs
