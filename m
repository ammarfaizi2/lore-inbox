Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWFND5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWFND5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 23:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWFND5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 23:57:14 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:18180 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751130AbWFND5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 23:57:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=W2ZrJGpcccZis/fGN2oCcJs8o6QoqjVdgvPPPQBpVuG349nxl39cO++SvByVRY1F9tvyTZKOPSWcjA55k5wiJsFOXBfpxea2P6a/cR/19X4XcQwrgtjBkltnxwQnj7jZP+xnMBBOejaKwJ7xTVLzB5B1fpa8sjzbddHCS+2kck8=
Message-ID: <986ed62e0606132057l3fe9ab9as2d512132cf203a5e@mail.gmail.com>
Date: Tue, 13 Jun 2006 20:57:12 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm3: "BUG: scheduling while atomic" flood when resuming from disk
Cc: mingo@elte.hu, arjan@linux.intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
In-Reply-To: <20060604225140.cf87519f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <986ed62e0606042223l2381d877g4bc798ec64804d43@mail.gmail.com>
	 <20060604225140.cf87519f.akpm@osdl.org>
X-Google-Sender-Auth: f6034cb48fa26f8b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/06, Andrew Morton <akpm@osdl.org> wrote:
> > [  487.203000] ACPI Exception (acpi_bus-0070): AE_NOT_FOUND, No
> > context for object [c174d620] [20060310]
>
> And this?

FWIW, I just found out that there was a new BIOS released for this
motherboard (MSI K8T Neo), and I just applied the update. The version
number jumped from 2.2 to 7.1, and judging from the appearance of the
BIOS screens, you would think that I had completely replaced the
motherboard. Anyway, so far, the new BIOS is now autodetecting the
memory timings correctly (previously it used to think my memory was
CAS3, not the CAS2 that it actually is), and I've just managed to
resume from S3 using the Ubuntu kernel without the computer
spontaneously rebooting and without experiencing video corruption or a
blank screen. (The S3 video problems used to happen under Windows XP
too, but I haven't yet tried that OS after the BIOS update.)

I probably won't be able to test an mm kernel again on this box for
several days (right now I'm dealing with both final exams for the
school quarter *and* hardware failures on other boxes). Once all that
is over with, I'll have to retest with the latest mm kernel at that
point.
-- 
-Barry K. Nathan <barryn@pobox.com>
