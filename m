Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSDJVzg>; Wed, 10 Apr 2002 17:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313900AbSDJVzf>; Wed, 10 Apr 2002 17:55:35 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:58536 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S313898AbSDJVzf>; Wed, 10 Apr 2002 17:55:35 -0400
Date: Wed, 10 Apr 2002 17:55:29 -0400
From: Bill Nottingham <notting@redhat.com>
To: hch@ns.caldera.de, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: psaux change in -ac breaks USB keyboard + PS/2 mouse
Message-ID: <20020410175529.A22665@wierzbowski.devel.redhat.com>
Mail-Followup-To: hch@ns.caldera.de, alan@redhat.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change (from 2.4.18rc2-ac2):

o Improve handling of psaux open with no mouse present (Christoph Hellwig)

breaks the handling of the case where there is a PS/2 mouse
and no PS/2 keyboard (for example, USB keyboard.) In this
situation, the first time /dev/psaux is opened, it will return
-ENXIO. Subsequent opens appear to act normal.

Bill
