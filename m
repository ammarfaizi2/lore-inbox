Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130443AbRBMLAv>; Tue, 13 Feb 2001 06:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRBMLAl>; Tue, 13 Feb 2001 06:00:41 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:60109 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130443AbRBMLA2>; Tue, 13 Feb 2001 06:00:28 -0500
Date: Tue, 13 Feb 2001 10:57:17 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@transmeta.com>, timw@splhi.com,
        Werner Almesberger <Werner.Almesberger@epfl.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <E14Sd3v-0001OF-00@the-village.bc.nu>
Message-ID: <Pine.SOL.4.21.0102131056180.15957-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Alan Cox wrote:

> > That's the whole crux of the matter.  For something like this, you *will*
> > drop data under certain circumstances.  I suspect it's better to have
> > this done in a controlled manner, rather than stop completely, which is
> > what TCP would do.
> 
> Why do you plan to drop data ? That seems unneccessary.

If the kernel starts spewing data faster than you can send it to the far
end, either the data gets dropped, or you block the kernel. Having the
kernel hang waiting to send a printk to the far end seems like a bad
situation...


James.

