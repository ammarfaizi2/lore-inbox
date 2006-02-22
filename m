Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWBVWNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWBVWNv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWBVWNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:13:49 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:28280 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030319AbWBVWN2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:13:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=az7dNLp+s3daO+OdBcz+wZ+JzzFHqIkHXWXb8awUX/Wy4XjqL7PZ9bTQb+dNCt6y29qp/vDZpMgvasv6HoSQwdmRuRPkx7ZW9uLTGny60zPhLqqmGEtNd8cqWrmnIxsGfDCEhDsQfs6SRthW59D4HPFqCS3j7CCw29/+sDgNlyQ=
Message-ID: <d120d5000602221413i19aac43cv43820051f2de9c7@mail.gmail.com>
Date: Wed, 22 Feb 2006 17:13:26 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Suppressing softrepeat
Cc: "Pete Zaitcev" <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       stuart_hayes@dell.com
In-Reply-To: <20060222220954.GA7930@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060221124308.5efd4889.zaitcev@redhat.com>
	 <20060221210800.GA12102@suse.cz>
	 <20060222120047.4fd9051e.zaitcev@redhat.com>
	 <20060222204024.GA7477@suse.cz>
	 <d120d5000602221309n58cad283q41a79e6fe013042d@mail.gmail.com>
	 <20060222220954.GA7930@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Wed, Feb 22, 2006 at 04:09:33PM -0500, Dmitry Torokhov wrote:
> > > How about simply this patch instead?
> > >
> > > Setting autorepeat will not be possible on 'dumb' keyboards anymore by
> > > default, but since these usually are special forms of hardware anyway,
> > > like the DRAC3, this shouldn't be an issue for most users. Using
> > > 'softrepeat' on these keyboards will restore the behavior for users that
> > > need it.
> >
> > I am not keen on changing the default behaviour... How many dumb
> > keyboards are out there?
>
> Apart from the DRAC3, some home-made Sun-to-PS2 converter, and a single
> non-x86 embedded box, I don't recall anything. Answer: very few.
>
> There may be users, though, that use this option to force the detection
> of the keyboard when not really plugged in, eg. for flaky KVMs. I've
> Googled for that usage, but found none.
>
> > I'd rather turn atkbd.softrepeat into a 3-state switch...
>
> We could, but the more I think about it, the stronger I'm convinced that
> the dumbkbd => softrepeat => softraw option implication chain is wrong.
> The second implication is necessary, but with dumbkbd it's quite likely
> you won't want softraw.
>

OK, then I'll schedule this change for 2.6.17 and we'll see if anyone screams.

--
Dmitry
