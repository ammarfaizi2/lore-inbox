Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWGTTqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWGTTqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 15:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWGTTqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 15:46:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:24918 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030367AbWGTTqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 15:46:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GkgfV+N8Iy5raRPa454BeB4qlCQL47/bIUcgsHOFYQQyThkMFIOzuj/jnWXIkBRcHSk1ytYoRESdB/xZpuFVOLOzwrlsbAxoJjwhXZ5JfMzc1KPQKNMT6hkZ6hsXoJ7u3Pc/936ePe6kVgL6ftIyzNo6PdiwJDgVj9AQ6LmlkfQ=
Message-ID: <d120d5000607201246s6af0223o83be95ef54147f10@mail.gmail.com>
Date: Thu, 20 Jul 2006 15:46:12 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "George Nychis" <gnychis@cmu.edu>
Subject: Re: thinkpad x60s: middle button doesn't work after hibernate
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <44BFD911.70106@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44BFD911.70106@cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/06, George Nychis <gnychis@cmu.edu> wrote:
> Hey guys,
>
> I recently got the suspend to disk working and suspend to memory working
> thanks to many of you.  Whenever I suspend to disk and resume, the
> middle mouse button on my thinkpad x60s no longer works for scrolling or
> for pasting.  I either have to reboot, or suspend to memory and resume.
>  Therefore:
>
> Initial Boot: working
> Suspend to disk -> resume: not working
> Suspend to memory -> resume: working
>
> To fix it for now, i simply suspend to memory and resume after resuming
> a suspend to disk.
>

It sounds like psmouse resume method either not getting called or
fails during resume from disk. Could you do:

echo 1 > /sys/modules/i8042/parameters/debug

before suspending and send me dmesg after resuming. Make sure you have
big dmesg buffer.

Thanks!

-- 
Dmitry
