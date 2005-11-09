Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbVKIKcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbVKIKcm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 05:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbVKIKcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 05:32:42 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:42903 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S1030466AbVKIKcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 05:32:41 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: video4linux user land API concern
Date: Wed, 09 Nov 2005 10:26:59 GMT
Message-ID: <05G2L0Z12@briare1.heliogroup.fr>
X-Mailer: Pliant 94
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any Video4Linux driver should support both native hardware color encoding
(for maximum performances) and rgb (for maximum flexibility).

Requiering user land tools to be prepared to match the webcam native color
encoding is poor kernel API design for several reasons:
. some software will say 'I will work only if your camera support the encoding
  I want' (surf the Internet and you will discover that it's already sadely true)
. small tools that make Unix flexibility get hard to write and test without
  relying on glue libraries, and glue libraries are evil
. if new color models appear in new cameras, the current design will require
  to map them anyway to some existing encodings not to break existing softwares,
  so the end result will be even more confusing because the driver supporting a
  non rgb encoding will not necessary mean that selecting the encoding is better
  from the performances point of view

