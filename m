Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWENXWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWENXWk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 19:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWENXWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 19:22:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:3120 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751396AbWENXWj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 19:22:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pDNjEe6xwjO4zU/GW2MspknlSJ5jXSG9u3VYm9P/hIvXvIb/ZZUxIjSJCSSpvJ7lxuJP5t75NO4qdrMVBdmpjOc8XV8mTIlGKKeQ+njJBTsoHl15W9KptMYCRKomm/qetUVvpS7ddlWOuGQ8bbm7ABYCsmwYX4RWiS5ViX8+DFo=
Message-ID: <70066d530605141622o30c9497dp8f571b575b2a706e@mail.gmail.com>
Date: Mon, 15 May 2006 07:22:37 +0800
From: "Jaya Kumar" <jayakumar.video@gmail.com>
To: "Oliver Neukum" <oliver@neukum.org>
Subject: Re: [PATCH/RFC 2.6.16.5 1/1] usb/media/quickcam_messenger driver
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200605141812.29333.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605141411.k4EEBaO4022817@localhost.localdomain>
	 <200605141812.29333.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/06, Oliver Neukum <oliver@neukum.org> wrote:
> Am Sonntag, 14. Mai 2006 16:11 schrieb jayakumar.video@gmail.com:
> > +static int qcm_setup_on_open(struct uvd *uvd)
> > +{
> > +qcm_sensor_set_gains(uvd, uvd->vpic.hue,
> > +uvd->vpic.colour, uvd->vpic.contrast);
> > +qcm_sensor_set_exposure(uvd, uvd->vpic.brightness);
> > +qcm_sensor_set_shutter(uvd, uvd->vpic.whiteness);
> > +qcm_set_camera_size(uvd);
> > +qcm_camera_on(uvd);
> > +return 0;
> > +}
>
> This function can generate IO errors. You should not simply drop them.

You are right. I was lazy about that. I'll put in a macro like
CHECK_RET(qcm_camera_on) for all the calls that do IO.

Thanks,
jaya
